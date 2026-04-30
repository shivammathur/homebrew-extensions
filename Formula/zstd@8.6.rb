# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT86 < AbstractPhpExtension
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
    rebuild 2
    sha256 cellar: :any,                 arm64_tahoe:   "921f2854d2728c15938c8b0f0c3c77443d350586110af5bfff9c30f32a3b57c3"
    sha256 cellar: :any,                 arm64_sequoia: "ef554a19120c8cd1da3fcb55fdb062ddb036ede07cb046bb90a51e336c81da65"
    sha256 cellar: :any,                 arm64_sonoma:  "c84d7d453b182581847639560c22758755a46cefcb341c0fa2800fb4845ae14b"
    sha256 cellar: :any,                 sonoma:        "6a81c154a72c672ce29cb1563888bd92a1a62c94f615a1083cffc4b2cfba99b3"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "36af6c2c058ff8e7d271f8c85147c52be2dd7b66c0123e3638e1f1a2b1a2cf94"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8c6134a51e479e6426b6638b2a3dce9b4b7ffb5b0a33bd53106fc1129a688bde"
  end

  depends_on "zstd"

  def install
    Dir.chdir "zstd-#{version}"
    inreplace "zstd.c", "XtOffsetOf", "offsetof"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-libzstd", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
