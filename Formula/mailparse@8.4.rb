# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT84 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.6.tgz"
  sha256 "a69f1605583eabdb59c2cd4c17334b3267398a1d47e1fd7edb92d8bef9dee008"
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "b0b6f263d1a7cdf8041530d562dfe97b14cd4f35a7a590cc3912d5fdf06d4f6d"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4cdf5fda8f49e6c6c764d7d18b64dba13d770e3dc2b05f29b6a307bbe596bd04"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "b851175272bb65d03b58155137d58d63e3cceb53ba8a64f86a417b525f17285a"
    sha256 cellar: :any_skip_relocation, ventura:        "649314d56f3b757c931577d9e121dc47a64756f3148077530dd63fd821e3307e"
    sha256 cellar: :any_skip_relocation, monterey:       "baaf38bbb466e36e9b9822044958d66884ba2276c86d18603388309786564528"
    sha256 cellar: :any_skip_relocation, big_sur:        "a0f83851e1a3d7fb22c6629e3f2caf7912c1d76ada51548f5473a0bf055d797b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "81c5322a16b393b9532e343752e2b86f2497785391649638b93e32a702c2b405"
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
