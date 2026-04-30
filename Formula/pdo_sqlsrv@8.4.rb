# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT84 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.13.1.tgz"
  sha256 "350a5d66a13be11fadff6eb0d7391e58c1b8af2cd0abe141263f5af1930feb69"
  head "https://github.com/Microsoft/msphpsql.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/pdo_sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "6f909fab566dbab6738880766da14b7c185f72ac8c7b293fe6fdec3630e3bdc5"
    sha256 cellar: :any,                 arm64_sequoia: "6bd84711837475e8de5042a036d1d028b82d529b7ea12d2ce2dd062af0e3b5dc"
    sha256 cellar: :any,                 arm64_sonoma:  "d8ba9829bcd715a16789dc031c5d9e79839f9e4ee9e9c098dbf4326ef7a2a468"
    sha256 cellar: :any,                 sonoma:        "83a53c0e6779100bdd3aa7cdecbfaaa7391376e8666b4e58176dd234665c6e75"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4ac21d04883613a11ed2452167348b4783837862f95e26a48a454e6b199a5816"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "79f35c98284cc780adb9961945c2c768d13c78ee35b5cf64593753ec8e2cf656"
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
