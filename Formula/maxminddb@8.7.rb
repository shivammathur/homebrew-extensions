# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT87 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "63328604ecc31e7887350136bfa5b64bc397b3ba362e86652012a4283a5a3fe8"
    sha256 cellar: :any, arm64_tahoe:       "2166c7a5fe6f3e278e6cbae23019b61ecbaa345dac369c28bda45de1acd91aea"
    sha256 cellar: :any, arm64_sequoia:     "6e3f4fec2d69ab490293ef764c677115213c05dc3e739807cc5b5d870d1890de"
    sha256 cellar: :any, arm64_linux:       "4a0f29399f9832013af6043269f81197bdafd93945852be8847b790ee224ec2f"
    sha256 cellar: :any, x86_64_linux:      "1963b3eefc5aeda4034346d8bf13de8b9fec8ca912230484fc1ee795d3c5cec7"
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
