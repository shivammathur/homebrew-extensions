# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT83 < AbstractPhpExtension
  init
  desc "MaxMind DB Reader PHP extension"
  homepage "https://github.com/maxmind/MaxMind-DB-Reader-php-ext"
  url "https://pecl.php.net/get/maxminddb-1.15.0.tgz"
  sha256 "49412f02d31d28861f56c05f043ed21a1e8c444b53ac47292da502a4d1fdaa2b"
  head "https://github.com/maxmind/MaxMind-DB-Reader-php-ext.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/maxminddb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "41cb7992319167b49861c6214e95db825cc30540a66ab3c359452f480f7a5d7a"
    sha256 cellar: :any, arm64_tahoe:       "f7fb0a311528c1deae69c87f695dcf598a19672e2ccfa4c3e1b464f42a7c3c72"
    sha256 cellar: :any, arm64_sequoia:     "8930456a7d50cabc2d8ad7a8b8b38fa9a0ff960943497706b53e7d1dd3fb9cd1"
    sha256 cellar: :any, arm64_linux:       "f6344163d616f75795611bbb4c570f952abb2663e11cc69667cf6b79567227b6"
    sha256 cellar: :any, x86_64_linux:      "6bbf452e0c9fed24fcaf0d892c2b1bb7875866281ed40fb39c0ecde3303601a4"
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
