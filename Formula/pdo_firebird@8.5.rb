# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT85 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.5.7.tar.xz"
  sha256 "01ba2ed1c2658dacf91bebc8be6a4885f69b811c7993831fc48e26107ab29985"
  head "https://github.com/php/php-src.git", branch: "PHP-8.5"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.5(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "b8e2b3e3f146000fdf65a858be119a11c08dd0c2c87a579ea794c20275a9c8fe"
    sha256 cellar: :any, arm64_sequoia: "c12681fc7e775a3951ac4b308c125f8ba8107a54503c14fb29fd7c29f2916f57"
    sha256 cellar: :any, arm64_sonoma:  "f2c74c1f84fb6874eb7861817572043838e86db911ae4ded96de10b9fac48736"
    sha256 cellar: :any, sonoma:        "fd1469299a2af2495dea461f7366ea6298c166bbe44758dd19226d8283834fdc"
    sha256 cellar: :any, arm64_linux:   "a5708fcd046fcc0494ba46670e6c7953de73db2168d986a47537f3944af0917f"
    sha256 cellar: :any, x86_64_linux:  "a5538a53a2f584a298e6883c4672c7c82d95a7e9b7903b62bb211644bbcc8cd0"
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
