# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT80 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.21.tgz"
  sha256 "1033530448696ee7cadec85050f6df5135fb1330072ef2a74569392acfecfbc1"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "518832b2f9726bd24222aea033f541e5304ec4bf862265d21f8ad2a2f3528433"
    sha256 cellar: :any_skip_relocation, big_sur:       "877db22261b4146ca0e2fe92ac480ed43555d6c4074dc08a13120140aa3af846"
    sha256 cellar: :any_skip_relocation, catalina:      "32cfb2405fb97a337c243e157e59aff17aef8bd91c7322a23a37f198621276df"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f8fd9c96ebdec4a67932e806d2a62d107e1895f7e964d72f7deaad36ddd41ec7"
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
