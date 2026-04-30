# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT86 < AbstractPhpExtension
  init
  desc "MaxMind DB Reader PHP extension"
  homepage "https://github.com/maxmind/MaxMind-DB-Reader-php-ext"
  url "https://pecl.php.net/get/maxminddb-1.13.1.tgz"
  sha256 "362839e6a0a50f6253d46ae11b3cae80520582e2b5528423aed9644577a3a93d"
  revision 1
  head "https://github.com/maxmind/MaxMind-DB-Reader-php-ext.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/maxminddb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "c219c8f82301360eddd36397a59e46e3ea926287935500ec39a3f63112f62540"
    sha256 cellar: :any,                 arm64_sequoia: "4a6c71487efcbd5685f0a65b801ddd0ca3f4c3324ae0e1e02ba534421e75d497"
    sha256 cellar: :any,                 arm64_sonoma:  "26248678788bab722a240ff74b677e5b21e81e5ea745f5c32d2f02fe6123aaf3"
    sha256 cellar: :any,                 sonoma:        "4f4ec6debf50b0ab4902a4d253544d77164ba9cae05350c7c9a71d7fbfd8582e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "cd8011301c112a5e6643e62737ecbda72ad7ebb2803a208bb4c96c96a7723222"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "08ab3bace97540b77554b55a62c5c2139e08c971906bf3b86248fdda2d82df3b"
  end

  depends_on "libmaxminddb"

  def install
    Dir.chdir "maxminddb-#{version}/ext"
    Dir["**/*.{c,h}"].each do |f|
      next unless File.read(f).include?("XtOffsetOf")

      inreplace f do |s|
        s.gsub! "XtOffsetOf", "offsetof"
        s.sub!(/\A/, "#include <stddef.h>\n")
      end
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-maxminddb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
