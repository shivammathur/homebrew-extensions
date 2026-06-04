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
    sha256 cellar: :any,                 arm64_tahoe:   "dd3e2832eb1de696a38bd9c12f8636e240916b0b10d7a7cd3203165cb5bf52c5"
    sha256 cellar: :any,                 arm64_sequoia: "ad4a7565ec971cdaff3ba8ce65de4a4feb2f607267bdecf404f5721bc762e9ed"
    sha256 cellar: :any,                 arm64_sonoma:  "81c9a422f9345dd71ff2cd90cd3374fcac42e34359d28787e97d8b915f81f1ff"
    sha256 cellar: :any,                 sonoma:        "0b0bf49208954c13a34cc44a74fb25bd8440fed925c79964760dfcd33c2cafe8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c7d662c343da458a3df16c5dbca469d5ab228e97a28c477dc2524b5879091f2b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "01afcdca23872824e561d8154af203f296f1738a0f77beeaf26b49cc414a595d"
  end

  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client"].opt_prefix
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
