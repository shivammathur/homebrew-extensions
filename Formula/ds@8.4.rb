# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT84 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-1.4.0.tgz"
  sha256 "a9b930582de8054e2b1a3502bec9d9e064941b5b9b217acc31e4b47f442b93ef"
  head "https://github.com/php-ds/ext-ds.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1a49c62633f1ac6cd127a215d20ce5e25e059a58444858099c1210307a6c3133"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "ebb24be146fd994d84741a9bb7606aae5a96b4ce08f734f7a11b327e1222f949"
    sha256 cellar: :any_skip_relocation, ventura:        "a5efea4419fc4239647ddd587502dd5e79650a793b31481fedab9347581fbdbc"
    sha256 cellar: :any_skip_relocation, monterey:       "d0b8916f1e4e806e5ff83e183d71769153914a57fed84ee163715e83b0f57b97"
    sha256 cellar: :any_skip_relocation, big_sur:        "392ae40a38cce9ccefa9854094df87cd4ae78ce37ff7f93561154ca78b4d09ec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9d45436e3aa962a24fb7a9b4de6bd4f345ce97369bcbf10c66f41a797661f5a2"
  end

  priority "30"

  def install
    Dir.chdir "ds-#{version}"
    inreplace "src/common.h", "fast_add_function", "add_function"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ds"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
