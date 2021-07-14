# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT81 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://github.com/shivammathur/apcu/archive/8729b34c2d9a6d6527783894617bc4f0d559ca16.tar.gz"
  sha256 "f66cac2929891cca289ddbeacefc24fae2b39e140fdffa997d4e61affe145e49"
  version "5.1.20"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "be29fcefe7c7b7c2f46ceef70c74dad9c93945673825a175225bbc10a61472d3"
    sha256 cellar: :any_skip_relocation, big_sur:       "d44f0cba74a0e468fa2e3ed2d6c6d2cc0b71ff4697fa386667bc99cad189cee1"
    sha256 cellar: :any_skip_relocation, catalina:      "eab84b8e42f69e7675167270705a4f6ba11db72395268959d04c6e8077043429"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
