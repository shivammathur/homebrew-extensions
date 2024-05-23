# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.7.0.tgz"
  sha256 "1c82b5c4d7329229daa21f77006781e92b7603627e7a643a2ec0dbf87b6cc48e"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "ffffd84dae9429b73422ff9bb9e9f9932f8d94e7143ccf46a569588eda2b2da0"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "dd57b5c05c899283f234fd7787799344e629d5f980728f51546010625cc4ed04"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "bf7475eda1cf86b592cc9eb7893943ef50145befa3b1e8863d906ec034d9ec98"
    sha256 cellar: :any_skip_relocation, ventura:        "da90632584ee8c54c4a17f4a22cdf4338e05bd3937638d5e51bcee573002a446"
    sha256 cellar: :any_skip_relocation, monterey:       "e72873aac8b9a06a39ba1f36f6234fcdadc78ebac41e1f104cec070821c827b3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0ee860cd938cfa349b75824c3240d55c3c516d26985ccb82e7cbec442ea2927c"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
