# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT83 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.8.tgz"
  sha256 "59beab4ef851770c495ba7a0726ab40e098135469a11d9c8e665b089c96efc2f"
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mailparse/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c0288899e1d20265c0abbf923754e9b0aaa5cd5e59a6f9a9981c003a85073625"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a3e782d57fc95a14888ae730d5cbfac8e551ccc3a7943f80ab7312ff915441f7"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "9c0f83ec09f46b64121cab08081c9050111a3c273325269b95b4cc770dc01049"
    sha256 cellar: :any_skip_relocation, ventura:       "b1404e06d3e10b5df3ef5b4cd9e9e0cfb8936326aa4860b6a6f91b8da8f66ba8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a168764f628bfa6bdd9d941f7118c7471aa867969e56d5a18dcc0c940c450fc2"
  end

  def install
    Dir.chdir "mailparse-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mailparse"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
