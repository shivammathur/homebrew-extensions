# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT73 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.7.tar.gz"
  sha256 "21863908348f90a8a895c8e92e0ec83c9cf9faffcfd70118b06fe2dca30eaa96"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "657df41974458c8fbd2a468d748fd13813869d311a1ae26090a5330dd40e5f94"
    sha256 cellar: :any_skip_relocation, big_sur:       "7c6c3894ce9b730c099798ef3af74aac707b366a01fdc1249a4493e77c06c611"
    sha256 cellar: :any_skip_relocation, catalina:      "d0edd7e44db1266d946d14a0f26b25687df9da29e1032fb8c110c85e7bad1ca6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "03e642b201e4b5567a46d756989cd470cd098d75ff6aa839bbdd4ced8c094da5"
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
