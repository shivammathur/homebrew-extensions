# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT72 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/418ed8a42fc1ff3f1f434873c4d453713d4164ea.tar.gz"
  version "7.2.34"
  sha256 "8b8104c40d0e453088f8fe703a0ead74ffdb5a4d0deb9b102864aa206bef5d2b"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any, arm64_tahoe:   "5d6f5b42d50f919dae291d8d4e5e3fcb19d60d74c4592279d3b6850197f7ef2f"
    sha256 cellar: :any, arm64_sequoia: "52b86f723e6dd885b2e2aace849be66e9f36618ee8578eb5ee7c11d5a5f66314"
    sha256 cellar: :any, arm64_sonoma:  "284bc7bcfec3ec47fa6781c218470ede1476db99c4c5020c89f071f0be813d2a"
    sha256 cellar: :any, sonoma:        "cc841d0fd196eb6a59cf11fc012bc6a92b107ba01fc950ad1933de4b37cabe06"
    sha256 cellar: :any, arm64_linux:   "f4fe87f57e78096cd7a3078790943ff8a045a5b259de2af4b2b45133c4aa8a79"
    sha256 cellar: :any, x86_64_linux:  "93132d24a836fc8752472a5f907ac18e7af6f9eaf2858a2413576695e1603ed2"
  end

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client@3")
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
