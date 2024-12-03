# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT70 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.24.tgz"
  sha256 "5c28a55b27082c69657e25b7ecf553e2cf6b74ec3fa77d6b76f4fb982e001e43"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "337ad98d3d38b5fa590ed3d0a0fb48b82044c4c93eefc2b0a0db4dec85a4cd78"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f84f7ac3727970aad669aad4ed1944244773a28525a2ad65fd7b303da3cdea68"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f80b3644e9dece23e9cb76239d5135647f8f2864aa7bb37172e2b44e774ee696"
    sha256 cellar: :any_skip_relocation, ventura:       "6e033842c0376dd851aff46567f30340214e95ce72177f43b658a6b7e4a1aac6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "61d72afd75f49addb22fb35aea6c8c50839a26107761bd368d634757e8f1cb4e"
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
