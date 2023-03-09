# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT83 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.11.0.tgz"
  sha256 "c307d9bcada02bdc21f59b9f099031b90b30727757bca50fd42fd36159812e8a"
  head "https://github.com/Microsoft/msphpsql.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "821ef21e6f4628f78769eb7bb218e83ec1d73fcb837ec5a4f6a509f059a7631d"
    sha256 cellar: :any,                 arm64_big_sur:  "22882b7d7e8db7f1b0612d8eeb003b1bff98e2817137215326e5f89b13705c90"
    sha256 cellar: :any,                 monterey:       "619c99b5f8328c0e73ed80f76488dea4ef33e37d0069c3018aeeffc47b6d7482"
    sha256 cellar: :any,                 big_sur:        "fcb29a69fc1657bcb86e6f0a15e458dddc816059814bb4a3a7e66410a14587a3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2523bd2e7b17cf02ff66919e7ee7952a523aadbc3888ef403a107fd13d503b7f"
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
