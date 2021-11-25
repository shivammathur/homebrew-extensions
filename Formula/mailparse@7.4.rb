# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT74 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.2.tgz"
  sha256 "b0647ab07ea480fcc13533368e38fdb4f4bb45d30dce65fc90652a670a4f4010"
  head "https://github.com/php/pecl-mail-mailparse.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "a464b43f6010309792aea032d1ec5c0952b0278369ca87785390dcc543d9e2e4"
    sha256 cellar: :any_skip_relocation, big_sur:       "09495b262881097da56045c0275d1a58831c069d587f8a35925d50e54ee3fb58"
    sha256 cellar: :any_skip_relocation, catalina:      "c164889909e4b6e0651da179a48ade191684534f9a779a1c8d4aa9e31fd8754d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a6467357ef38f09ba93953e4a156fddadc1db7774cc401f3041e2a1eeb7e2dfb"
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
