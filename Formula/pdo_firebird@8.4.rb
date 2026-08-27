# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT84 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.4.25.tar.xz"
  sha256 "dc1ad8b4109898d9db49744450403874858c23efc685b1032a50bd1e83906848"
  head "https://github.com/php/php-src.git", branch: "PHP-8.4"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.4(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "193ffa3fd96f46e7591826c1af3f3fabd23ee911f28a7816c88264064476a713"
    sha256 cellar: :any, arm64_sequoia: "a5db28324474e0a6179d309b3d328a8b5002f9b020c280d5734aefcf3566ae50"
    sha256 cellar: :any, arm64_sonoma:  "5b27d1c11b6e29414278e3433e2ec726e6ef97912f935919e30bc06d304b7b7f"
    sha256 cellar: :any, sonoma:        "580bd03b64a11350bea4cb5d578c8fffd62ccc0c450c512125bf3cd11161768e"
    sha256 cellar: :any, arm64_linux:   "f6122f56be66b346878e12d5a4f8942d4818c9516b4bb9d0788c1ba5a7c1f80b"
    sha256 cellar: :any, x86_64_linux:  "6b01d8b45779ec113ee285fea5a0cab672054715ca5d0fc6a22debdadd9d6d68"
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
