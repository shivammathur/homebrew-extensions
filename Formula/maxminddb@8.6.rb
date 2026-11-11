# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT86 < AbstractPhpExtension
  init
  desc "MaxMind DB Reader PHP extension"
  homepage "https://github.com/maxmind/MaxMind-DB-Reader-php-ext"
  url "https://pecl.php.net/get/maxminddb-1.14.0.tgz"
  sha256 "c06351f1360bd651057ea73e0186d8fec744292839a4b49c71ce886072c4fff7"
  revision 2
  head "https://github.com/maxmind/MaxMind-DB-Reader-php-ext.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/maxminddb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "d0c1ec48ee8fd46eaeb27ab5efd55e16028d223a08c6187041a1a7c1f6e3b6c8"
    sha256 cellar: :any, arm64_tahoe:       "b3f68f856a1adbe9e77c3e1281ef28585b98117bc6c0d7108f54bf9cb8de6a86"
    sha256 cellar: :any, arm64_sequoia:     "fe8a7efd6609da6c0c0f10df4fe386f8e0ba7685bc3b240561162837904efcd0"
    sha256 cellar: :any, arm64_linux:       "5069ca63b7451459796dbe88e813bc3b8e2429ed7df5004011e508ebfced251b"
    sha256 cellar: :any, x86_64_linux:      "5e4ed63e700d0ba1d7b5e2bbdf705ff7440b730e9a27394967564c3092d86bb4"
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
