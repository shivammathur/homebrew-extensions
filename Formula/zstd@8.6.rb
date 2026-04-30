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
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "0304dd02d76f52dd37522eb701fe992d7890998cf560dd449a7a5f6b40b3a8a4"
    sha256 cellar: :any,                 arm64_sequoia: "64d4a1f1256197ad34c7cef19cb79b3ba2fac8aee8e7ecc7ee7c15d2f47fd682"
    sha256 cellar: :any,                 arm64_sonoma:  "64fb6340fa2c60a3d63ff82be53d540d2b537f5a890495e9b45af14feb6778cc"
    sha256 cellar: :any,                 sonoma:        "6ccf4f0b2ffeab1136355972fe71d941d95f7349e0be433823cf0147eb2cf680"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "dfce7643f463182092660f9733811154e8be7976dd8eae722fdf017577ff4dbe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ab97ed76000100867a7a8c663fb034dbfeca6693e936f0fd5395fbee83ab97fa"
  end

  depends_on "zstd"

  def install
    Dir.chdir "zstd-#{version}"
    Dir["**/*.{c,h}"].each do |f|
      next unless File.read(f).include?("XtOffsetOf")

      inreplace f do |s|
        s.gsub! "XtOffsetOf", "offsetof"
        s.sub!(/\A/, "#include <stddef.h>\n")
      end
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-libzstd", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
