# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT83 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.32.tar.xz"
  sha256 "8698ec1f9402fa5e5e872ae3d0916b62f5f27503c1fbfc9cc3521e113355ea92"
  head "https://github.com/php/php-src.git", branch: "PHP-8.3"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.3(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "cb9259b7ec0c98b7173ff2ebdd0a16ed5dc1c3c6964ae8332e7374035b51f71c"
    sha256 cellar: :any,                 arm64_sequoia: "750d705f8e2303e663300603414825e08b477941599624c6fac4f853dd63e062"
    sha256 cellar: :any,                 arm64_sonoma:  "51c6140c825a23bc27ae3aec8916971495418d492eca5c47a18c4abcc1b6873c"
    sha256 cellar: :any,                 sonoma:        "efe0fea2e0f9de4bbe7d937e2fe15f203af832abc47ae01e7cf9ef044b857143"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "565ff39a1f9849d1a4472555940a84b4fb7544f8b017af16f6633cdd0b27a2d6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8f26052f6bd4b39b4574a31693b873971234a52d4fac4363a58ba040eb7d75e0"
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
