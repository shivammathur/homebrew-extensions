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
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "ba4dda596e0f6da8a12ce1541abfd9a0b65309e08199e5e95ebfba52b9817036"
    sha256 cellar: :any,                 arm64_sequoia: "336e03eb3b472b04f529cd182311ef8ca787c3aaac81f8e0ea8dc982d46865c9"
    sha256 cellar: :any,                 arm64_sonoma:  "e794c2927fcb432c24f2ef37f6d5549033f33fc8654544d87b071af05834f6a7"
    sha256 cellar: :any,                 sonoma:        "785a7a8c09598750e8882a272676ecf44ce13833f8a9a2cb936fc6850adb36e9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "41146018b0af41e9a014998409e8d16a8af15340169c115d61d2b37fa48eb38e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1b0a901536b7deab4bdc9f85edd1cadf9151a77930c9cce5354af6f64ad0128d"
  end

  depends_on "libmaxminddb"

  def install
    Dir.chdir "maxminddb-#{version}/ext"
    inreplace "maxminddb.c", "XtOffsetOf", "offsetof"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-maxminddb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
