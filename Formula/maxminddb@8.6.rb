# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT86 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "c9337d8bd8f88bdb88acd6a94525d3198d6ebc940d78cd5d3eccfeca962e9dd1"
    sha256 cellar: :any,                 arm64_sequoia: "7585817a951f400e68dadb584c7ac4da7b07a075faaec527a59be82197204aae"
    sha256 cellar: :any,                 arm64_sonoma:  "5a7c95385d695d5147cb69da26d6f47d6b2b0b24809013ebd1ceee412cc998f5"
    sha256 cellar: :any,                 sonoma:        "854c79d88b1c14b389a0f534925825f5784f2b1b42ac84afcafab79fc135c673"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "06796a54d7526f71067237c1d319fc9f921f7760baecacbe1ba811409144c2d2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "709f94c7bdad726f6c91d86eb9183e98608726a933f525b2792688c9eaae05d4"
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
