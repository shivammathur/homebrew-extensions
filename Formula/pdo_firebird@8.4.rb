# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT84 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.4.26.tar.xz"
  sha256 "32a2de53862ad44ed4a5005244ce4f1b50c271e74dced215449a4443b40569f1"
  head "https://github.com/php/php-src.git", branch: "PHP-8.4"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.4(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "b1614843985149a68a6b710e623ffca6463c552fe04e34e6cc8b175ecdf68553"
    sha256 cellar: :any, arm64_tahoe:       "5f485a90e5fef11d7f084ebe7353646e563d2163c29f33da9b7c8297b78a567c"
    sha256 cellar: :any, arm64_sequoia:     "705f2c61f44e42f9624fd34952c7dbb3070325d06d0fc63136db2fb2f7fb157f"
    sha256 cellar: :any, arm64_linux:       "63ec3f4a4ee1d1282558bc373d6f5b00b82b652badc324592b52cb723e8108f6"
    sha256 cellar: :any, x86_64_linux:      "b4fbcaf8ec5fc0ee688deb491f9cdab76d29f3eb31f01b664f16c04ad3236cc9"
  end

  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client")
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
