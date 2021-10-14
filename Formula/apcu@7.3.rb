# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT73 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.21.tgz"
  sha256 "1033530448696ee7cadec85050f6df5135fb1330072ef2a74569392acfecfbc1"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "ccc52540341b3ecd02b5a61e53730caafe98efa76501bfe690ebb7a9873c8bd9"
    sha256 cellar: :any_skip_relocation, big_sur:       "210debca0e7e71a806a6a15e70f4dee236756ed32d7bfb4dc9cf046d216868e2"
    sha256 cellar: :any_skip_relocation, catalina:      "90fe4142339dcf73474b3fe2c9b386a9e910e4ad23317458a02d635b12a98f82"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "eed176e4bd2a943b5b9cf8ad546652c8603f63fa3e37ac20c9a587c9d2e08742"
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
