# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT72 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.24.tgz"
  sha256 "5c28a55b27082c69657e25b7ecf553e2cf6b74ec3fa77d6b76f4fb982e001e43"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "193aafb798a9249e431d0f828be60c180598d4416324f550d576d281ef77e639"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "45192decf4a7bff5c6c3408953961d52f28cf59b31036d9bcb580d4345c56e95"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d20c3b2dc90686fd1fb9e96556be502dc9460bef3c8f1cad30f55acc43f77a46"
    sha256 cellar: :any_skip_relocation, ventura:       "2ff0b77ac36faaa9fd0ede81b1e0172d491dc649fc41c150f9d388271dfd1d94"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5e1d8e2f5bfe2831f2142f4ced8b9f31f55acbd95a280a843e0628a3c3a59510"
  end

  def install
    Dir.chdir "apcu-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
