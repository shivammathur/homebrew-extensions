# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "00d93da63b731ea446545a19611da8a010403a326965b7af8f2498bf507ce70e"
    sha256 cellar: :any,                 arm64_sonoma:  "246993d5834851439c0b4175e32c813173ec21344bb1c4cbc66a3e3f5a7b6350"
    sha256 cellar: :any,                 arm64_ventura: "a262615a370935f01d595fd13e56447c810fd91187e7fd8eaa8f76d298eeaa36"
    sha256 cellar: :any,                 ventura:       "c9660485b5d039cef89ba7d5db156d75fe9dc09655a5f91a963257c0a095a585"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ea9c027997c290cee722d0d5ea8072777bb6e386da03f0ce2068d9a1e7090876"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "557baf32ab43ea086da58b092b5aa06b64aae9d33072a0cba6008d702d72cac5"
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
