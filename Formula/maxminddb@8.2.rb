# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "8e97a8d74dd83fe48a3f12ca47a46579083af4f3eb854b2e3c6e4da523639572"
    sha256 cellar: :any,                 arm64_sequoia: "269cb80d42027cab1bc762581f04c4a2df4116428f28cd605340d4cbb07eda7c"
    sha256 cellar: :any,                 arm64_sonoma:  "f3b4cd13c71ce586c1663a4054a16d99b66cc3e2cac65e2b70163de4239f1e8d"
    sha256 cellar: :any,                 sonoma:        "c43e254c24e5d3893c9f1f1a06fa3c4a1ce5b148af2c5a123951d84b5fc01718"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ff98c3f19a12578567295af523811c9f1ebb06475f52d6abb5a217441334b3ee"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b8735b3fcdab6ff8d5e6b61f7bac54f1b6ecc79f9a970121b0054478d76052fc"
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
