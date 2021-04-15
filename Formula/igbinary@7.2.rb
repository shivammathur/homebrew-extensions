# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT72 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.1.tar.gz"
  sha256 "bc26f361f750bc9894741201e6851a3445a20d185969c08bf311264b7dc9cd6b"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "dab7c453a2ebfda563087c3bb51bfa7b2de3b2c3244895b9f93c4af82f982d8e"
    sha256 cellar: :any_skip_relocation, big_sur:       "c196784cfb9ef72204293ff0f0b7a3416007c3f281f1c3f4375ffbb38a49e058"
    sha256 cellar: :any_skip_relocation, catalina:      "a0edc771cc9f5fdde6fea6be6ff508666d1d76aee7e875a72194654e38936a1c"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
