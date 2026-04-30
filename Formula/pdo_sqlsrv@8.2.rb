# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT82 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.13.1.tgz"
  sha256 "350a5d66a13be11fadff6eb0d7391e58c1b8af2cd0abe141263f5af1930feb69"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/pdo_sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "eabb27aa5b3a8119d762737cbbc65564e6e11b2ec45eafd32084e9e3d0024de7"
    sha256 cellar: :any,                 arm64_sequoia: "08d0dce50462f6c27d1d3873880336b8c31556765ef8d340e5bd0adf4e237da6"
    sha256 cellar: :any,                 arm64_sonoma:  "82b7fe1d6fbb874ca5bd7024555192fd94664c1d19a1438903fb636213890a74"
    sha256 cellar: :any,                 sonoma:        "0854cea8f57fc68c3f5ad33d58f5a3ef763b7db04707fe2f00dc809f9d0ae3fa"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2a1892caaa0fe3c514d41a5e97cb015aa3f386eb27be4d0324276c6bcefc80dc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5913b8bf6b8ad516420a86e7f814200749035cf50bc6dc945089208e42b7005a"
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
