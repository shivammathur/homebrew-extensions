# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT56 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-1.1.2.tgz"
  sha256 "d35a49672e72d0e03751385e0b8fed02aededcacc5e3ec27c98a5849720483a7"
  head "https://github.com/m6w6/ext-raphf.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "dc1f7eb55443a5d12efebdf502a6884b76fd5b1cabe429db7527a39ee71f70db"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "9d4d4d53f38af0dc057898e5fbafacb416a7d7c790591d39fea2b36c59c4272e"
    sha256 cellar: :any_skip_relocation, monterey:       "91339bd86acb7c26a647d9af5a1e9a9b93d1ef60ffedf36337eac56ac46a13a7"
    sha256 cellar: :any_skip_relocation, big_sur:        "20789dd30fd504220d88516acb41b57062411275fae423014b151a5c9bf67c17"
    sha256 cellar: :any_skip_relocation, catalina:       "7a33e709afe0fd48e728fb03af84b14b4fa2b4aa0b06b07af9b7e5c5af62643a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9e3c3a7f3536eafb0f9bba721244799ad6993689ac9a291debb915872cb12ec8"
  end

  def install
    Dir.chdir "raphf-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
