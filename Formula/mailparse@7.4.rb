# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT74 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.6.tgz"
  sha256 "a69f1605583eabdb59c2cd4c17334b3267398a1d47e1fd7edb92d8bef9dee008"
  head "https://github.com/php/pecl-mail-mailparse.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "d287756e03eaf5a86eb5dd39e8772234a1ee3992976188e37ced046974b7e2de"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "c8a1f3348cdd9e38b357097317b623c2c8784c18b3070f5870adddb0ef92cef3"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c688fb3da6dc9fc44d72f77a0f787335421edb3d85c35a4f0b35a8eeee9919bc"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "d222f95bc982dcf498d93686239efc91377f059900c84c1a5879c0fad8c8e430"
    sha256 cellar: :any_skip_relocation, ventura:        "07ff5952ddc81765258e1e986a8c9db7cd5b8863b0a355e35cb82a68e37dda0b"
    sha256 cellar: :any_skip_relocation, monterey:       "86aa9fd36dc385a6f1382c9cbc4c1ae52e48c5d8e93ed0fa738e49ef32a41b11"
    sha256 cellar: :any_skip_relocation, big_sur:        "789139e92a12a91422fb25708847ac7d3f3e7d62a90b037c9ad22afa63f94f0c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0d6be6e67297140d381fcb6345f4f033a214538a8f18512a2cc07df24afa44af"
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
