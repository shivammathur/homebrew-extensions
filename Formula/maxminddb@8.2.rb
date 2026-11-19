# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT82 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "42d4c4bf8559b722f2c056485544ae5ff0f0d73d6ce10d8776a270b6a26fd735"
    sha256 cellar: :any, arm64_tahoe:       "7b8f5bade7704a12b39d723eba8474093e8904ce6f03578891a900bacd1a9d70"
    sha256 cellar: :any, arm64_sequoia:     "f8f6b83412d3f1df9474396d1e944880b5a661b89353b23b1380a3f8e70d1835"
    sha256 cellar: :any, arm64_linux:       "baa24a241cd6a470eb06a87874d3f9bd76518e264ba15820e0e459c8a940d40d"
    sha256 cellar: :any, x86_64_linux:      "715e6692684a47aa86d4cd4e0d43df0fb5fb73327e0c55947e602f545cfca0f0"
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
