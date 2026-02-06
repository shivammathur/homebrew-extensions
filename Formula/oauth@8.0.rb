# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Oauth Extension
class OauthAT80 < AbstractPhpExtension
  init
  desc "Oauth PHP extension"
  homepage "https://github.com/php/pecl-web_services-oauth"
  url "https://pecl.php.net/get/oauth-2.0.10.tgz"
  sha256 "1fd5e074dacf5149603493c454b476d69850bec0a71d7ea69a36a00db728a0fb"
  head "https://github.com/php/pecl-web_services-oauth.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/oauth/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "ff09b2696d9beb77d14f2e951a4b3fa9c814136c34f69a4d567ad5fc09c4d8a2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "706ad35bd6a57f09aa4c34fa3503764cd1068d04f06bdff3eddb6bf19c9e8353"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d4390a87eea0f12d1ae956e67ed18de41a1593f077aa8b1de1d605ecbf48e954"
    sha256 cellar: :any_skip_relocation, sonoma:        "00d858f6267bfdb9dadec9c7f95a8b338b4afd26e21f6377e891472b54740417"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4792a0fdb58c46690436f7b698e48463f993002f338ba6e8f1cb7c0cb50685a3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "496b706813d72c90f30b61807904224194338cdc8b30c8d93f3f9b4ad9d1ba9d"
  end

  depends_on "curl"

  def install
    Dir.chdir "oauth-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-oauth"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
