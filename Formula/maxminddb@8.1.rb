# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT81 < AbstractPhpExtension
  init
  desc "MaxMind DB Reader PHP extension"
  homepage "https://github.com/maxmind/MaxMind-DB-Reader-php-ext"
  url "https://pecl.php.net/get/maxminddb-1.13.1.tgz"
  sha256 "362839e6a0a50f6253d46ae11b3cae80520582e2b5528423aed9644577a3a93d"
  head "https://github.com/maxmind/MaxMind-DB-Reader-php-ext.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/maxminddb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "654cb990f88749db87b1a181f84c4104a052d06e29e127d4f8a6b31408cbb244"
    sha256 cellar: :any,                 arm64_sequoia: "30971ca063f89e182fad9df766b747440a9b5ec1f789453e655b4844eb475bd6"
    sha256 cellar: :any,                 arm64_sonoma:  "c0ed8aac53245cfe1484fc29b466fe821939c0ceab296b5f355d7ec29294e12e"
    sha256 cellar: :any,                 sonoma:        "ecf49a7bdff799dfa0b2bfced1d0ebf29f89069aa06b9b9198fbb004cbb3cbcb"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1fccc3ca76961817d65f27b12090a2ab284dae954b21998361d400494c30fc4f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "884f31fde4d2db0f3bc62243a37d823e2467a57e61637e159c2fca98258ec437"
  end

  depends_on "libmaxminddb"

  def install
    Dir.chdir "maxminddb-#{version}/ext"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-maxminddb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
