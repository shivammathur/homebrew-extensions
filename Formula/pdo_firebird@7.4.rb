# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT74 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "a3b8509db6d4340a8216619b159fc3c2f6b4cd0cc07c94a4fbf02ee0bf932c30"
    sha256 cellar: :any,                 arm64_sequoia: "d1d2c24d95de1483d9141df68d4d6bd4ac2b1b23cb019341218877ef8ef3287f"
    sha256 cellar: :any,                 arm64_sonoma:  "6f4d02c95fd71180a505ff51c13bfcb1e531ae8b099cb3c92a2a5318e569ad23"
    sha256 cellar: :any,                 sonoma:        "967bd9a7e6752214a9f7ccc9f7a03c4a0cde1ad642c344f09a4849e3497f0124"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e1dc1e9a8676e37024a87987263dff2efc9be24d82fad37dd999b2cf0006ed1a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5785955c7cad6e11860e703743ce6524830156f2496a9ccb2bc64794cdd52f41"
  end
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/4ab83a550530c864e4bef29b054f81f71874d8be.tar.gz"
  version "7.4.33"
  sha256 "1593ea9ebe9902aa1dcc5651e62de5cd38b67ac636e0e166110215592ab1f820"
  license "PHP-3.01"
  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client@3"].opt_prefix
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
