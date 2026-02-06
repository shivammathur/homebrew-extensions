# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Oauth Extension
class OauthAT72 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "a3334c0b20313ab3af77673d73c127c2aa9a30dc064b0b4843b193682d05ced5"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2f146c1ebbbb981d1b128e6d93063e14af0c90cfc607ab43b79fac6493dff870"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a84c774fc6a58da03e411d1e349fc97737d6c20ccbb451bdafe6d2c1378b3b07"
    sha256 cellar: :any_skip_relocation, sonoma:        "431d76da2bf4f1312d29bb2324fd220f16e9fadc61bad7be0a9f1b7ffb73f2bc"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1ade1eca6bdd6fbb087b5cbcdc8a2a3d327eeca9aa60e88d421c9b56f15eb8f9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1bceb8325134883f1cd38f0dde789a7badbbf84780edd0fbe7989969bb3ea273"
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
