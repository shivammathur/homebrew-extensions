# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/0fb074d860346877aa33eee8131a6eaf4a932608.tar.gz?commit=0fb074d860346877aa33eee8131a6eaf4a932608"
  version "8.6.0"
  sha256 "a8f694482347f3d4d4b710de5782cb395ac66cd1743a285bb62fbc10388dfbb3"
  revision 3
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any, arm64_golden_gate: "475124ee1eb9bdb33b554dd7d05efdd72ee784d14a21bb15885c77753f13569c"
    sha256 cellar: :any, arm64_tahoe:       "ca299c33b131d5d78753bb30158f9ef9ef6f28e56a8c2964c905a05308b20084"
    sha256 cellar: :any, arm64_sequoia:     "94935455f5b9cca56c837ae97ba6fc3c886e35a0499a6cc9022cc4cbffc7d4f1"
    sha256 cellar: :any, arm64_linux:       "1265cb79d2703299b49f168e9f22bf58a4865bfd5c1ac37db85a54b65af41e8e"
    sha256 cellar: :any, x86_64_linux:      "4bd45f02e6566aa3cd04af08ce490693683ef8a8cc8ef99560f839885af7ac9a"
  end

  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client")
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types" if OS.mac?
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
