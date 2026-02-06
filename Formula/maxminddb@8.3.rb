# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT83 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "37261386d826b3b5d4daec3de1e16546a9aca2864c3002f381fda5da172a4461"
    sha256 cellar: :any,                 arm64_sequoia: "965b7435d97f73982d455725cdc2079886451951fa5831937190f5071697594d"
    sha256 cellar: :any,                 arm64_sonoma:  "0214e9e065b3b75e7514513533adb9be5f37be1706200122c51117ea715056ea"
    sha256 cellar: :any,                 sonoma:        "657f37db7cd72dadf066262a38af23bbffab2af686673a5e5a782a42c8a7d45e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3405e66be213536ac3189d04c5ff4da8d26b3e5ee9da7084b8b1060f289e7338"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d2e9f0a3ab1f58a157ee46b315034228af8078a3c4ef6fcd5d6a21412c2da58b"
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
