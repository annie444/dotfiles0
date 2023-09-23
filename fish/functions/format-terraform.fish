function format-terraform
  set -l pwd (pwd)
  for i in (/bin/ls -d */)
    echo "Entering: $pwd/$i"
    cd "$pwd/$i"
    for extra in (/bin/ls -d */) 
      echo "Entering: $pwd/$i/$extra"
      cd "$pwd/$i/$extra"
      terraform fmt
      cd "$pwd/$i"
    end
    terraform fmt
    cd "$pwd"
  end
  terraform fmt
end
