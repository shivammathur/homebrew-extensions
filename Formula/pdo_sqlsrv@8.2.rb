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
    sha256 cellar: :any,                 arm64_tahoe:   "079284a3e7f93292e570c283dea8e4427db5e2d32bdc7fdbc3531a569f4bcee5"
    sha256 cellar: :any,                 arm64_sequoia: "811b061f20a6e9975fa18fc9d3911ddccae8b32c3986eb8a6e4d6bc3380d4c13"
    sha256 cellar: :any,                 arm64_sonoma:  "9a8d516827d1b016a6c1d56ef25867f7a8d124c4bb17ca99b965345e33050326"
    sha256 cellar: :any,                 sonoma:        "15b7ecbc7d430ada1bd0e852d0e083a0f9091dc44275e53ba8e2b483e5490d6a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "14edc7fc71bc45576a23cd42b6224483d161c67314c628d469bc30833f0adf79"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "34dde790c0973ac05d1ada291b602ea9b49adc980fb746d816f44b11453f8a65"
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
