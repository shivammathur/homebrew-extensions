# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT83 < AbstractPhpExtension
  init
  desc "MaxMind DB Reader PHP extension"
  homepage "https://github.com/maxmind/MaxMind-DB-Reader-php-ext"
  url "https://pecl.php.net/get/maxminddb-1.14.0.tgz"
  sha256 "c06351f1360bd651057ea73e0186d8fec744292839a4b49c71ce886072c4fff7"
  head "https://github.com/maxmind/MaxMind-DB-Reader-php-ext.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/maxminddb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "0b84b45b563bf83023eaaa83fadbf2cd27459ab95b4757587d34c21c3c7b1e11"
    sha256 cellar: :any, arm64_sequoia: "671902c0cf34999925657ea1ef45901c74ac29fb3e4e2b82023c81f365b32c75"
    sha256 cellar: :any, arm64_sonoma:  "ad9a9d20e520f94cc20f64fd7ce599ddcc43fbf9afe10b479d86439de40d78b2"
    sha256 cellar: :any, arm64_linux:   "69de10b59ed4079954d23097b4d67fcb0d7fae3cb53137076b60f2f9ab1c1197"
    sha256 cellar: :any, x86_64_linux:  "13f5048352c59cb6c463361d4dcc9f95027ea0b9df19bcff88eb089f02248587"
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
