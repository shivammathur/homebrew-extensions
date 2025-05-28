# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT83 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.12.0.tgz"
  sha256 "22f0cb17b45f0deccd0bba072ee0085ff4094cd6ee2acc26f7f924975ef652c6"
  head "https://github.com/Microsoft/msphpsql.git"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/pdo_sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "d3dc100480d59ae6f0a9de4e97b0a8bde00521e37c81c8f7ba46310ec3e89d37"
    sha256 cellar: :any,                 arm64_sonoma:   "18109729d2f30e5f96d999e6685c5bb9fd02f9078d810385ed10fc3f6c36856c"
    sha256 cellar: :any,                 arm64_ventura:  "c05e9953eb5da5568c1fb9d9d2e240a3f89bfcbc8f485ee02020136e4bd4be00"
    sha256 cellar: :any,                 arm64_monterey: "77af9cf706b82db008d2265464d33e881b87f22529df44acf9b0516344b9b0b6"
    sha256 cellar: :any,                 ventura:        "79d4602cedffcc9b65df01927b3c43ab04a39282447355187edd3e7a26227b0f"
    sha256 cellar: :any,                 monterey:       "0f9d868e029e0436a76cd98a157a019fe462ca8bbeff5478c992aed77ca30500"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "15ba6ea377f8e0b02507a630d2f366c536b4355964c9bf5c089d2a7fe6041c8e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "86db71dabe5cfef790d54cd45df545f8d18b772c16dcb8ca27cff33589d8b8d4"
  end

  depends_on "unixodbc"

  def install
    Dir.chdir "pdo_sqlsrv-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-pdo_sqlsrv"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
