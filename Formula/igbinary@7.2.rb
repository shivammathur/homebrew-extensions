# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT72 < AbstractPhp72Extension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.1.tar.gz"
  sha256 "bc26f361f750bc9894741201e6851a3445a20d185969c08bf311264b7dc9cd6b"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "408d71595d341f5a455c949d18532b59cf222955cf05974298e178520c0291e2"
    sha256 cellar: :any_skip_relocation, big_sur:       "5f353bb49e80e37dc68d4cb6fbbe8264a9cdf53ae5f12a0b8ce8fcbec8f1b27f"
    sha256 cellar: :any_skip_relocation, catalina:      "1a6ce756a4fbb6ddb65eb64c1575841f890df3160651c6d1102dba7d600e7fcc"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
    add_include_files
  end
end
