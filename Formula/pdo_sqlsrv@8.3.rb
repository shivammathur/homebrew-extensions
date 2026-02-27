# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT83 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.13.0.tgz"
  sha256 "efa859bcc48d97f25268dbdebf1db25f25610d7fa36b3ee91073c1c99411e24c"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/pdo_sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "a36c3f47c819148b571b1dd7a44a75536128cf588d15adaa0b91260e0e7a6ae7"
    sha256 cellar: :any,                 arm64_sequoia: "8b8abcdc2a6463cc3e8f8234bf41589456f290c4650434edfc83504955414be9"
    sha256 cellar: :any,                 arm64_sonoma:  "97ca78d5d1dd698fb0e5bd0834a68ae28673ce882410e64f5140dfee636fe11e"
    sha256 cellar: :any,                 sonoma:        "34a9d2fa622c2c2b9689933cc11f00210c5e93ad62f7166aa5ffcd6dc2893f24"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3f7559c3991c3ca222ae9f8247895f563edba336f941a18d0d472a44c1facc9f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4a571e313ae1eee1c7277881e65a1ba73f6267e6629e5b03f3c10f872016dfa4"
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
