# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT80 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.13.3.tgz"
  sha256 "198a7b37da0658d36a93d158a0ec179b137b3a4d241c90a6650ae9ee8f91ec4a"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/pdo_sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "ccb59c0734c490523ad4c7c22a78599c7faef35928ba3a9fab8e31244ee0d00c"
    sha256 cellar: :any, arm64_sequoia: "fed092c88b20a59c37dbbbe0f135328a67f72851ffeea61e33ba5a35fdaba158"
    sha256 cellar: :any, arm64_sonoma:  "8496afe72ddbe4825b51660450d0e6fd171c7a095a3b51201f48a16dfbe8ca32"
    sha256 cellar: :any, sonoma:        "72c072d40d91e13515d7da7399e3663aa5e290afd08d0dc53bd5abfdff937fff"
    sha256 cellar: :any, arm64_linux:   "250657d5307d41fe6350a7f93bb4cffb641e38476faca18948fa4658c67d0b62"
    sha256 cellar: :any, x86_64_linux:  "49fc20fceaa10ce7ec623bc9c33400318db3c86180f132de0f2ee053eca801dd"
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
