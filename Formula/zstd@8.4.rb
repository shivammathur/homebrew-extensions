# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT84 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.15.2.tgz"
  sha256 "fd8d3fbf7344854feb169cf3f1e6698ed22825d35a3a5229fe320c8053306eaf"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "b61837aed5b5b2f46c1f615613fff8d5671147ca4bcc7e80156d74ae97f922a6"
    sha256 cellar: :any,                 arm64_sonoma:  "699a3b8e93c3188557effbb72ebf018efb06a328c9ea23f113b4040cd396cb92"
    sha256 cellar: :any,                 arm64_ventura: "b9ba66dd8625ae65cd2f9cc0cea3c6ab398def096ae60c3cb8ddc2e6ca092a2e"
    sha256 cellar: :any,                 ventura:       "d1e9ae506600502c587164db167604a052cdd726d650458d6222a2b685bc2cc0"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2156c6399525d647353435212371b67124cd0104a5ec26d923c5d45fd46692b8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "34fa1916a940a4ba703bc3ec66ff3c4157fb5f7810207417bb194caf516122d7"
  end

  depends_on "zstd"

  def install
    Dir.chdir "zstd-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-libzstd", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
