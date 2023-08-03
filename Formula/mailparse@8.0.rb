# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT80 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.5.tgz"
  sha256 "34c685c102a6b57a3f516e9d8fc8ef786bd191c321d0f5d1d3764c1f1ee20620"
  head "https://github.com/php/pecl-mail-mailparse.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b749842b23af6b83a51721b2e873932e895462a01bedf8806ca16d4300a15406"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "69baf3eeca6e0452b30cccd82f088f5c25861f01958ab0124c9a26c3ecde07f8"
    sha256 cellar: :any_skip_relocation, ventura:        "577bbc5ddc1b31f3d6f9cb1b4797bbfc35c6e38fa5c6a9c3718589c49ed69380"
    sha256 cellar: :any_skip_relocation, monterey:       "ff4ebc08fcd31443d6643a9b85eb9f924410dce20c7601bd8f0c8e6161542e4f"
    sha256 cellar: :any_skip_relocation, big_sur:        "26df639f24d2782f9d2ab90ce4b0f76bb712f887c42eb7923162ebb39fe1e142"
    sha256 cellar: :any_skip_relocation, catalina:       "c08ffe6ba96345f8153f4e48c2bfebb1b7f041f7aca1ce7890eba9c1a8f79a24"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "39c0f2f3cf41eed249b1e26ecd3cfdaca2fa0d83ff5e17f43017b8ce03c0d36f"
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
