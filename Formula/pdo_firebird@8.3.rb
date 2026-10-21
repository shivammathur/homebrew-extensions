# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT83 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.36.tar.xz"
  sha256 "dd54693aa334c5c4d72e9aee96b082c2473750a18a6c1d105789c93a3b1692fd"
  head "https://github.com/php/php-src.git", branch: "PHP-8.3"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.3(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "72cd1c83baaf0ca02212438bc4645f42553d350d7f0386201419b10a11988156"
    sha256 cellar: :any, arm64_tahoe:       "c55ebd240021254775b6803e3b2bded40e94acd6ea3e98eec3115c964859e1e1"
    sha256 cellar: :any, arm64_sequoia:     "f0be17515dc53641b2036d299234ebec31363001fb04657e81606872101f3a79"
    sha256 cellar: :any, arm64_linux:       "ee3ce2d4d6a6b700f0f5cbe2b1e3620e4fce2444f26306f84a895a5b1a882252"
    sha256 cellar: :any, x86_64_linux:      "e2996b80162de008df4b09763358c530cd77674888f49b5fc9940275078727fc"
  end

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client@3")
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
