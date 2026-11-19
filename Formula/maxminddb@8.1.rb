# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT81 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "2fa103ecc0cfedcb4938053e837c6a40d873b5e71a3eef8a05ce3246599238e8"
    sha256 cellar: :any, arm64_tahoe:       "40d387c8595d36ea9f5650e3ec5eceee213f7ccca234eaa0bb97e28a641d1c87"
    sha256 cellar: :any, arm64_sequoia:     "eb67317e8dd611926bb4562e444efee2befd42e76ef23ddc670b776b530b833a"
    sha256 cellar: :any, arm64_linux:       "a6073e93e7300036f276a436d45a7ae351c84cb9e68fc9c8bce24cfb5e66cd94"
    sha256 cellar: :any, x86_64_linux:      "3e7675c99492d9767e50ff9d61edc1bb801d31c787c8e112517adf51957a71fe"
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
