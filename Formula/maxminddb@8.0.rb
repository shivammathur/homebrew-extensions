# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT80 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "abf4a15c09836b7347fc658787a94baa8c4f062e3156a26620c4565c2bd3317a"
    sha256 cellar: :any, arm64_tahoe:       "f48076880826d15f09b41f240b8cb082dedc0f39f10966f25281fc250b4f9e22"
    sha256 cellar: :any, arm64_sequoia:     "c4c2585bffe0070bb52823f07cfb68e2f940350b5bccc2db1d9d1b26721bed75"
    sha256 cellar: :any, arm64_linux:       "dc635c0bbe34cc372737a859ff6bbb56aa2c33924c7bb6149a21c37af5a358c2"
    sha256 cellar: :any, x86_64_linux:      "0be34d371dceeac0b69eca7152dffd9f6a9ab8d4e59c55731d43fe41106463ff"
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
