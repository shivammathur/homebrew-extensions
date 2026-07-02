# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT82 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.32.tar.xz"
  sha256 "e02aa173c236c12791696254d607da680e6d5516f8f5c2339642de7c4f944bd2"
  head "https://github.com/php/php-src.git", branch: "PHP-8.2"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.2(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "892e50b8ef6cc642734131507adbffada55d2e432859a21f6eb0302bbbe9f0a0"
    sha256 cellar: :any, arm64_sequoia: "b9fb110afa24e1d4b97ce60b11489f30c788d4d3ac188c018962dafd9395b655"
    sha256 cellar: :any, arm64_sonoma:  "9b85b73f0437f088d232c416af8b23a0169b62ef29b105dc34d6af9a04101922"
    sha256 cellar: :any, sonoma:        "176a1c52f97ed25f5f0c854335496c8707f84247ae00a79041dc94cfef557aaa"
    sha256 cellar: :any, arm64_linux:   "daef29376cb1c07c49cc2d14c4ab3f717e0368f0dc85afd258b1fe1135e85177"
    sha256 cellar: :any, x86_64_linux:  "c0ab22413904ec6c8fca17037c84fda64e4c11df12ddf137c5d373b89447f982"
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
