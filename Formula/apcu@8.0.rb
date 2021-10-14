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
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "5ec789f5acf6b68fe689e6e5e096ec500efda1b511ab4ac56ce982ee7cde64cf"
    sha256 cellar: :any_skip_relocation, big_sur:       "0fb728ef29e37a536c9066d1f9e33f3f0affe8a86bf90ecd760d9b71dafa9451"
    sha256 cellar: :any_skip_relocation, catalina:      "a8b47acd8d9075f018a3b981e9f4c7962ae056cd1a36c48f6095e3c4759275c5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ab8566100f1890ca4a821f4f0e4fabb7f3001537fc4cbc3280b869297aa16d04"
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
