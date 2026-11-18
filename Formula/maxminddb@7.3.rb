# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT73 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "a39da4a0869473f237253191f6f8fa3f2bea84de4f6781dd86e7c35cc82c455a"
    sha256 cellar: :any, arm64_tahoe:       "3339af1dd6a05d477c1cbf48dad62b9ff069e676342d09d47390458ddf3d0332"
    sha256 cellar: :any, arm64_sequoia:     "32783e999bc9709a2e33de0b9cc72f39343de51e3944fb5141a17dae41ade9b9"
    sha256 cellar: :any, arm64_linux:       "d3dfe03834f0bc793c79a8fc0efba6f2035414d0904e483626797105a84ae54b"
    sha256 cellar: :any, x86_64_linux:      "94e2351d9f372bfe69289636c29a36a9aa5861b406cbc567d1b943822a1aa04e"
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
